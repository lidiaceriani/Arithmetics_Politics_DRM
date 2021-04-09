/*global  pc"/Users/lidia/Dropbox/Collaborazioni/Bolch_Ceriani_LopezCalva_Arithmetics_and_Politics/Paper/2011_WD/R1/"
global data "${pc}/Data"
global out "${pc}/Data"
*//*
PPP 2005  1.65
*/

* The poverty headcount we find with a poverty line of 2$ 2005 PPP corresponds to
* a poverty line of 2.8$ 2011 PPP

wbopendata, indicators(FP.CPI.TOTL ) long clear country(PER)
sum fp_cpi_totl if year==2010
local cpi_2010 = r(mean)
sum fp_cpi_totl if year==2005
local cpi_2005 = r(mean)
sum fp_cpi_totl if year==2011
local cpi_2011 = r(mean)

use "${data}/PER10.dta", clear
keep pc_cons weight mieperho
gen wt = weight*mieperho

local cons  pc_cons
local wt  wt
local ppp2005 1.65
 
di `cpi_2005'
di `cpi_2010'
gen y = ((`cons' *`cpi_2005')/`cpi_2010')/`ppp2005'

gen z=	2*365/12
gen r= 13*365/12 // Above the US poverty threshold 9Ravallion, 2010)

*gen pc_cons_2011ppp = ((pc_cons *`cpi_2011')/`cpi_2010')/1.57918
*gen z_29_2011ppp = (2.9*365)/12

preserve
* Generate definition
*-------------------------------------------------------------------------------

*Generate poor, non poor, middle class and rich indicator
	gen p=0
	replace p=1 if y<z
	gen np=0
	replace np=1 if y>=z
	gen m=0
	replace m=1 if y>=z & y<r
	
*Generate poverty gap, excess poverty gap, richness gap
	gen pg=z-y if p==1
	replace pg=0 if pg==.
	
	gen epg = 0
	replace epg=y-z if np==1
	
	gen rg=0
	replace rg=y-r if y>=r


*Generate number of poor and non poor
	gen i=1
	collapse (sum) p np m pg epg rg i [w=`wt'] 
	rename p Qp
	rename np Qnp
	rename m Qm
	rename i  N
*Generate total poverty gap, eccess poverty gap, richness gap
	rename pg Spg
	rename epg Sepg
	rename rg Srg
	
	list Qp Qnp Spg Sepg Srg in 1

* Indices
*-------------------------------------------------------------------------------
 	
*Poverty
	gen P0=Qp/N

* Middle Class
	gen M0=Qm/N
	
*Income lever proportional
	gen IL_prop=Spg/Sepg
	
*Income lever progressive A
	gen IL_progA=Spg/Srg


*-------------------------------------------------------------------------------
* Compute PEC-Index
*-------------------------------------------------------------------------------

keep  Sepg Spg Srg

	forvalues t = 0(1)2000{
	gen PEC_np_`t' = (((`t'/2000)*Sepg) / Spg)
	gen PEC_r_`t' = (((`t'/2000)*Srg) / Spg)
	}
	
	gen i = 1
	reshape long PEC_np_ PEC_r_, i(i) j(t)
	rename PEC_*_ PEC_*
	gen PEC_np_cap = PEC_np
	replace PEC_np_cap = 1 if PEC_np>1
	gen PEC_r_cap = PEC_r	
	replace PEC_r_cap  = 1 if PEC_r>1
	replace t = t/2000

save "${out}/PER_PEC.dta", replace

gen test=1
keep i PEC_r_cap PEC_np_cap test
collapse (sum) PEC_np_cap PEC_r_cap test, by(i)

local varlist "PEC_r_cap PEC_np_cap"
foreach v of local varlist{
replace `v' =`v' / 2000
}

rename PEC_r_cap pec_r_i
rename PEC_np_cap pec_np_i

restore
*-------------------------------------------------------------------------------
* Compute PIC-Index
*-------------------------------------------------------------------------------
			sort y
			gen i=_n
				
			count
			local N=r(N)
				
			gen y_i = 0
				
			forvalues j=1(1)`N'{
				local k=`N'+1-`j'
					replace y_i = y[`k'] in `j'
			}

xtile qt=y, nq(10000)
collapse (sum) y y_i [w=`wt'], by(qt)
gen i=_n
drop qt

			gen Sy = sum(y)
			gen S_y = sum(y_i) 

			gen temp  = .

			count
			local N=r(N)

			forvalues i=1(1)`N'{
				forvalues j=1(1)`N'{
					
					if S_y[`i'] >=Sy[`j']{
						replace temp = `j' in `i'
						}
					else{
						local ++j
						}
						
				} // j
			} // i

keep i temp
rename temp pic
replace pic = pic / 10000
replace i = i / 10000

save "${out}/PER_PIC.dta", replace

* Prepare PIC_I
*-------------------------------------------------------------------------------
preserve
collapse (sum) pic

replace pic = pic/10000
replace pic = (pic* 2) - 1

restore

