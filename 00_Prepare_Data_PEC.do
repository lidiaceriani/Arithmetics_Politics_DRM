clear all
set more off
*===============================================================================
* Compute The Poverty Eradication Capacity Curve
*===============================================================================
global project "C:/Users/wb436991/Dropbox/Collaborazioni/UNU_WIDER/Analysis"
*global project "/Users/Lidia/Dropbox/Collaborazioni/UNU_WIDER/Analysis/"
global data		"${project}/Data/dataverse_files/povcal_full"
global out 		"${project}/Data/Data_new"
global table 	"${project}/Tables"

use "${out}/IL.dta", replace

*Keep only most recent year
	bysort countrycode: egen max_year=max(year)
	keep if year==max_year

	keep country_year Sepg Spg Srg

	forvalues t = 0(1)2000{
	gen PEC_np_`t' = (((`t'/2000)*Sepg) / Spg)
	gen PEC_r_`t' = (((`t'/2000)*Srg) / Spg)
	}
	
	reshape long PEC_np_ PEC_r_, i(country_year) j(t)
	rename PEC_*_ PEC_*
	gen PEC_np_cap = PEC_np
	replace PEC_np_cap = 1 if PEC_np>1
	gen PEC_r_cap = PEC_r	
	replace PEC_r_cap  = 1 if PEC_r>1
	replace t = t/2000

save "${out}/PEC.dta", replace

* Compute PEC-Index
*-------------------------------------------------------------------------------
preserve
gen test=1
keep country_year PEC_r_cap PEC_np_cap test
collapse (sum) PEC_np_cap PEC_r_cap test, by(country_year)

local varlist "PEC_r_cap PEC_np_cap"
foreach v of local varlist{
replace `v' =`v' / 2001
}

rename PEC_r_cap pec_r_i
rename PEC_np_cap pec_np_i

save "${out}/PEC_I.dta", replace
restore
