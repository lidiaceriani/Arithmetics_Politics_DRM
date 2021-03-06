clear all
set more off
*===============================================================================
* Compute Political Influence Curve
*===============================================================================
fglobal project "/Users/lc1086/Dropbox/Collaborazioni/Bolch_Ceriani_LopezCalva_Arithmetics_and_Politics"
global data		"${project}/Analysis/Data/dataverse_files/povcal_full"
global out 		"${project}/Analysis/Data/Data_new"
global table 	"${project}/Analysis/Tables"


*local region "AFR1 AFR2 EAP1 EAP2 ECA1 ECA2 ECA3 LCN1 LCN2 LCN3 LCN4 MNA1"
local region "SAR1"

foreach r of local region{
import delimited  "${data}/povcal_full_`r'.csv", clear

* Generate countrycode compliant with WB standards
	gen countrycode=""
	replace countrycode="ABW"  if country=="Aruba" 
	replace countrycode="AFG"  if country=="Afghanistan" 
	replace countrycode="AFR"  if country=="Africa" 
	replace countrycode="AGO"  if country=="Angola" 
	replace countrycode="ALB"  if country=="Albania" 
	replace countrycode="AND"  if country=="Andorra" 
	replace countrycode="ANR"  if country=="Andean Region" 
	replace countrycode="ARB"  if country=="Arab World" 
	replace countrycode="ARE"  if country=="United Arab Emirates" 
	replace countrycode="ARG"  if country=="Argentina" 
	replace countrycode="ARG_u"  if country=="Argentina--Urban" 
	replace countrycode="ARM"  if country=="Armenia" 
	replace countrycode="ASM"  if country=="American Samoa" 
	replace countrycode="ATG"  if country=="Antigua and Barbuda" 
	replace countrycode="AUS"  if country=="Australia" 
	replace countrycode="AUT"  if country=="Austria" 
	replace countrycode="AZE"  if country=="Azerbaijan" 
	replace countrycode="BDI"  if country=="Burundi" 
	replace countrycode="BEL"  if country=="Belgium" 
	replace countrycode="BEN"  if country=="Benin" 
	replace countrycode="BFA"  if country=="Burkina Faso" 
	replace countrycode="BGD"  if country=="Bangladesh" 
	replace countrycode="BGR"  if country=="Bulgaria" 
	replace countrycode="BHR"  if country=="Bahrain" 
	replace countrycode="BHS"  if country=="Bahamas, The" 
	replace countrycode="BIH"  if country=="Bosnia and Herzegovina" 
	replace countrycode="BLR"  if country=="Belarus" 
	replace countrycode="BLZ"  if country=="Belize" 
	replace countrycode="BMU"  if country=="Bermuda" 
	replace countrycode="BOL"  if country=="Bolivia" 
	replace countrycode="BRA"  if country=="Brazil" 
	replace countrycode="BRB"  if country=="Barbados" 
	replace countrycode="BRN"  if country=="Brunei Darussalam" 
	replace countrycode="BRN"  if country=="Brunei"
	replace countrycode="BTN"  if country=="Bhutan" 
	replace countrycode="BWA"  if country=="Botswana" 
	replace countrycode="CAA"  if country=="Sub-Saharan Africa (IFC classification)" 
	replace countrycode="CAF"  if country=="Central African Republic" 
	replace countrycode="CAN"  if country=="Canada" 
	replace countrycode="CEA"  if country=="East Asia and the Pacific (IFC classification)" 
	replace countrycode="CEU"  if country=="Europe and Central Asia (IFC classification)" 
	replace countrycode="CHE"  if country=="Switzerland" 
	replace countrycode="CHI"  if country=="Channel Islands" 
	replace countrycode="CHL"  if country=="Chile" 
	replace countrycode="CHN"  if country=="China" 
	replace countrycode="CHN_r"  if country=="China--Rural"
	replace countrycode="CHN_u"  if country=="China--Urban"	
	replace countrycode="CIV"  if country=="Cote d'Ivoire" 
	replace countrycode="CIV"  if country=="C??te d'Ivoire" 
	replace countrycode="CLA"  if country=="Latin America and the Caribbean (IFC classification)" 
	replace countrycode="CME"  if country=="Middle East and North Africa (IFC classification)" 
	replace countrycode="CMR"  if country=="Cameroon" 
	replace countrycode="COD"  if country=="Congo, Dem. Rep" 
	replace countrycode="COD"  if country=="Congo, Dem. Rep." 
	replace countrycode="COG"  if country=="Congo, Rep." 
	replace countrycode="COG"  if country=="Congo, Rep" 
	replace countrycode="COL"  if country=="Colombia" 
	replace countrycode="COL_u"  if country=="Colombia--Urban" 
	replace countrycode="COM"  if country=="Comoros" 
	replace countrycode="CPV"  if country=="Cabo Verde" 
	replace countrycode="CPV"  if country=="Cape Verde"
	replace countrycode="CRI"  if country=="Costa Rica" 
	replace countrycode="CSA"  if country=="South Asia (IFC classification)" 
	replace countrycode="CSS"  if country=="Caribbean small states" 
	replace countrycode="CUB"  if country=="Cuba" 
	replace countrycode="CUW"  if country=="Curacao" 
	replace countrycode="CYM"  if country=="Cayman Islands" 
	replace countrycode="CYP"  if country=="Cyprus" 
	replace countrycode="CZE"  if country=="Czech Republic" 
	replace countrycode="DEU"  if country=="Germany" 
	replace countrycode="DJI"  if country=="Djibouti" 
	replace countrycode="DMA"  if country=="Dominica" 
	replace countrycode="DNK"  if country=="Denmark" 
	replace countrycode="DOM"  if country=="Dominican Republic" 
	replace countrycode="DZA"  if country=="Algeria" 
	replace countrycode="EAP"  if country=="East Asia & Pacific (developing only)" 
	replace countrycode="EAS"  if country=="East Asia & Pacific (all income levels)" 
	replace countrycode="ECA"  if country=="Europe & Central Asia (developing only)" 
	replace countrycode="ECS"  if country=="Europe & Central Asia (all income levels)" 
	replace countrycode="ECU"  if country=="Ecuador" 
	replace countrycode="ECU_u"  if country=="Ecuador--Urban" 
	replace countrycode="EGY"  if country=="Egypt, Arab Rep." 
	replace countrycode="EGY"  if country=="Egypt, Arab Rep" 
	replace countrycode="EMU"  if country=="Euro area" 
	replace countrycode="ERI"  if country=="Eritrea" 
	replace countrycode="ESP"  if country=="Spain" 
	replace countrycode="EST"  if country=="Estonia" 
	replace countrycode="ETH"  if country=="Ethiopia" 
	replace countrycode="EUU"  if country=="European Union" 
	replace countrycode="FIN"  if country=="Finland" 
	replace countrycode="FJI"  if country=="Fiji" 
	replace countrycode="FRA"  if country=="France" 
	replace countrycode="FRO"  if country=="Faeroe Islands" 
	replace countrycode="FSM"  if country=="Micronesia, Fed. Sts." 
	replace countrycode="GAB"  if country=="Gabon" 
	replace countrycode="GBR"  if country=="United Kingdom" 
	replace countrycode="GEO"  if country=="Georgia" 
	replace countrycode="GHA"  if country=="Ghana" 
	replace countrycode="GIN"  if country=="Guinea" 
	replace countrycode="GMB"  if country=="Gambia, The" 
	replace countrycode="GNB"  if country=="Guinea-Bissau" 
	replace countrycode="GNQ"  if country=="Equatorial Guinea" 
	replace countrycode="GRC"  if country=="Greece" 
	replace countrycode="GRD"  if country=="Grenada" 
	replace countrycode="GRL"  if country=="Greenland" 
	replace countrycode="GTM"  if country=="Guatemala" 
	replace countrycode="GUM"  if country=="Guam" 
	replace countrycode="GUY"  if country=="Guyana" 
	replace countrycode="HIC"  if country=="High income" 
	replace countrycode="HKG"  if country=="Hong Kong SAR, China" 
	replace countrycode="HND"  if country=="Honduras" 
	replace countrycode="HND_u"  if country=="Honduras--Urban" 
	replace countrycode="HPC"  if country=="Heavily indebted poor countries (HIPC)" 
	replace countrycode="HRV"  if country=="Croatia" 
	replace countrycode="HTI"  if country=="Haiti" 
	replace countrycode="HUN"  if country=="Hungary" 
	replace countrycode="IDN"  if country=="Indonesia" 
	replace countrycode="IDN_u"  if country=="Indonesia--Urban" 
	replace countrycode="IDN_r"  if country=="Indonesia--Rural" 
	replace countrycode="IMN"  if country=="Isle of Man" 
	replace countrycode="IND"  if country=="India" 
	replace countrycode="IND_r"  if country=="India--Rural"
	replace countrycode="IND_u"  if country=="India--Urban"	
	replace countrycode="INX"  if country=="Not classified" 
	replace countrycode="IRL"  if country=="Ireland" 
	replace countrycode="IRN"  if country=="Iran, Islamic Rep." 
	replace countrycode="IRN"  if country=="Iran, Islamic Rep" 
	replace countrycode="IRQ"  if country=="Iraq" 
	replace countrycode="ISL"  if country=="Iceland" 
	replace countrycode="ISR"  if country=="Israel" 
	replace countrycode="ITA"  if country=="Italy" 
	replace countrycode="JAM"  if country=="Jamaica" 
	replace countrycode="JOR"  if country=="Jordan" 
	replace countrycode="JPN"  if country=="Japan" 
	replace countrycode="KAZ"  if country=="Kazakhstan" 
	replace countrycode="KEN"  if country=="Kenya" 
	replace countrycode="KGZ"  if country=="Kyrgyz Republic" 
	replace countrycode="KHM"  if country=="Cambodia" 
	replace countrycode="KIR"  if country=="Kiribati" 
	replace countrycode="KNA"  if country=="St. Kitts and Nevis" 
	replace countrycode="KOR"  if country=="Korea, Rep." 
	replace countrycode="KSV"  if country=="Kosovo" 
	replace countrycode="KWT"  if country=="Kuwait" 
	replace countrycode="LAC"  if country=="Latin America & Caribbean (developing only)" 
	replace countrycode="LAO"  if country=="Lao PDR" 
	replace countrycode="LBN"  if country=="Lebanon" 
	replace countrycode="LBR"  if country=="Liberia" 
	replace countrycode="LBY"  if country=="Libya" 
	replace countrycode="LCA"  if country=="St. Lucia" 
	replace countrycode="LCN"  if country=="Latin America & Caribbean (all income levels)" 
	replace countrycode="LCR"  if country=="Latin America and the Caribbean" 
	replace countrycode="LDC"  if country=="Least developed countries: UN classification" 
	replace countrycode="LIC"  if country=="Low income" 
	replace countrycode="LIE"  if country=="Liechtenstein" 
	replace countrycode="LKA"  if country=="Sri Lanka" 
	replace countrycode="LMC"  if country=="Lower middle income" 
	replace countrycode="LMY"  if country=="Low & middle income" 
	replace countrycode="LSO"  if country=="Lesotho" 
	replace countrycode="LTU"  if country=="Lithuania" 
	replace countrycode="LUX"  if country=="Luxembourg" 
	replace countrycode="LVA"  if country=="Latvia" 
	replace countrycode="MAC"  if country=="Macao SAR, China" 
	replace countrycode="MAC"  if country=="Macau"
	replace countrycode="MAF"  if country=="St. Martin (French part)" 
	replace countrycode="MAR"  if country=="Morocco" 
	replace countrycode="MCA"  if country=="Mexico and Central America" 
	replace countrycode="MCO"  if country=="Monaco" 
	replace countrycode="MDA"  if country=="Moldova" 
	replace countrycode="MDA"  if country=="Moldova, Rep" 
	replace countrycode="MDG"  if country=="Madagascar" 
	replace countrycode="MDV"  if country=="Maldives" 
	replace countrycode="MEA"  if country=="Middle East & North Africa (all income levels)" 
	replace countrycode="MEX"  if country=="Mexico" 
	replace countrycode="MHL"  if country=="Marshall Islands" 
	replace countrycode="MIC"  if country=="Middle income" 
	replace countrycode="MKD"  if country=="Macedonia, FYR" 
	replace countrycode="MLI"  if country=="Mali" 
	replace countrycode="MLT"  if country=="Malta" 
	replace countrycode="MMR"  if country=="Myanmar" 
	replace countrycode="MNA"  if country=="Middle East & North Africa (developing only)" 
	replace countrycode="MNE"  if country=="Montenegro" 
	replace countrycode="MNG"  if country=="Mongolia" 
	replace countrycode="MNP"  if country=="Northern Mariana Islands" 
	replace countrycode="MOZ"  if country=="Mozambique" 
	replace countrycode="MRT"  if country=="Mauritania" 
	replace countrycode="MUS"  if country=="Mauritius" 
	replace countrycode="MWI"  if country=="Malawi" 
	replace countrycode="MYS"  if country=="Malaysia" 
	replace countrycode="NAC"  if country=="North America" 
	replace countrycode="NAF"  if country=="North Africa" 
	replace countrycode="NAM"  if country=="Namibia" 
	replace countrycode="NCL"  if country=="New Caledonia" 
	replace countrycode="NER"  if country=="Niger" 
	replace countrycode="NGA"  if country=="Nigeria" 
	replace countrycode="NIC"  if country=="Nicaragua" 
	replace countrycode="NLD"  if country=="Netherlands" 
	replace countrycode="NOC"  if country=="High income: nonOECD" 
	replace countrycode="NOR"  if country=="Norway" 
	replace countrycode="NPL"  if country=="Nepal" 
	replace countrycode="NZL"  if country=="New Zealand" 
	replace countrycode="OEC"  if country=="High income: OECD" 
	replace countrycode="OED"  if country=="OECD members" 
	replace countrycode="OMN"  if country=="Oman" 
	replace countrycode="OSS"  if country=="Other small states" 
	replace countrycode="PAK"  if country=="Pakistan" 
	replace countrycode="PAN"  if country=="Panama" 
	replace countrycode="PER"  if country=="Peru" 
	replace countrycode="PHL"  if country=="Philippines" 
	replace countrycode="PLW"  if country=="Palau" 
	replace countrycode="PNG"  if country=="Papua New Guinea" 
	replace countrycode="POL"  if country=="Poland" 
	replace countrycode="PRI"  if country=="Puerto Rico" 
	replace countrycode="PRK"  if country=="Korea, Dem. Rep." 
	replace countrycode="PRT"  if country=="Portugal" 
	replace countrycode="PRY"  if country=="Paraguay" 
	replace countrycode="PSE"  if country=="West Bank and Gaza" 
	replace countrycode="PSS"  if country=="Pacific island small states" 
	replace countrycode="PYF"  if country=="French Polynesia" 
	replace countrycode="QAT"  if country=="Qatar" 
	replace countrycode="ROU"  if country=="Romania" 
	replace countrycode="RUS"  if country=="Russian Federation" 
	replace countrycode="RWA"  if country=="Rwanda" 
	replace countrycode="SAS"  if country=="South Asia" 
	replace countrycode="SAU"  if country=="Saudi Arabia" 
	replace countrycode="SCE"  if country=="Southern Cone Extended" 
	replace countrycode="SDN"  if country=="Sudan" 
	replace countrycode="SEN"  if country=="Senegal" 
	replace countrycode="SGP"  if country=="Singapore" 
	replace countrycode="SLB"  if country=="Solomon Islands" 
	replace countrycode="SLE"  if country=="Sierra Leone" 
	replace countrycode="SLV"  if country=="El Salvador" 
	replace countrycode="SMR"  if country=="San Marino" 
	replace countrycode="SOM"  if country=="Somalia" 
	replace countrycode="SRB"  if country=="Serbia" 
	replace countrycode="SSA"  if country=="Sub-Saharan Africa (developing only)" 
	replace countrycode="SSD"  if country=="South Sudan" 
	replace countrycode="SSF"  if country=="Sub-Saharan Africa (all income levels)" 
	replace countrycode="SST"  if country=="Small states" 
	replace countrycode="STP"  if country=="Sao Tome and Principe" 
	replace countrycode="SUR"  if country=="Suriname" 
	replace countrycode="SVK"  if country=="Slovak Republic" 
	replace countrycode="SVN"  if country=="Slovenia" 
	replace countrycode="SWE"  if country=="Sweden" 
	replace countrycode="SWZ"  if country=="Swaziland" 
	replace countrycode="SXM"  if country=="Sint Maarten (Dutch part)" 
	replace countrycode="SXZ"  if country=="Sub-Saharan Africa excluding South Africa" 
	replace countrycode="SYC"  if country=="Seychelles" 
	replace countrycode="SYR"  if country=="Syrian Arab Republic" 
	replace countrycode="TCA"  if country=="Turks and Caicos Islands" 
	replace countrycode="TCD"  if country=="Chad" 
	replace countrycode="TWN"  if country=="Taiwan, China"
	replace countrycode="TGO"  if country=="Togo" 
	replace countrycode="THA"  if country=="Thailand" 
	replace countrycode="TJK"  if country=="Tajikistan" 
	replace countrycode="TKM"  if country=="Turkmenistan" 
	replace countrycode="TLS"  if country=="Timor-Leste" 
	replace countrycode="TON"  if country=="Tonga" 
	replace countrycode="TTO"  if country=="Trinidad and Tobago" 
	replace countrycode="TUN"  if country=="Tunisia" 
	replace countrycode="TUR"  if country=="Turkey" 
	replace countrycode="TUV"  if country=="Tuvalu" 
	replace countrycode="TZA"  if country=="Tanzania" 
	replace countrycode="UGA"  if country=="Uganda" 
	replace countrycode="UKR"  if country=="Ukraine" 
	replace countrycode="UMC"  if country=="Upper middle income" 
	replace countrycode="URY"  if country=="Uruguay" 
	replace countrycode="URY_u"  if country=="Uruguay--Urban" 
	replace countrycode="USA"  if country=="United States" 
	replace countrycode="USA"  if country=="USA"
	replace countrycode="UZB"  if country=="Uzbekistan" 
	replace countrycode="VCT"  if country=="St. Vincent and the Grenadines" 
	replace countrycode="VEN"  if country=="Venezuela, RB" 
	replace countrycode="VIR"  if country=="Virgin Islands (U.S.)" 
	replace countrycode="VNM"  if country=="Vietnam" 
	replace countrycode="VUT"  if country=="Vanuatu" 
	replace countrycode="WLD"  if country=="World" 
	replace countrycode="WSM"  if country=="Samoa" 
	replace countrycode="XZN"  if country=="Sub-Saharan Africa excluding South Africa and Nigeria" 
	replace countrycode="YEM"  if country=="Yemen, Rep." 
	replace countrycode="YEM"  if country=="Yemen, Rep" 
	replace countrycode="ZAF"  if country=="South Africa" 
	replace countrycode="ZMB"  if country=="Zambia" 
	replace countrycode="ZWE"  if country=="Zimbabwe" 

	drop  if z==.
	rename z y	
	bysort countrycode: egen max_year=max(year)
	keep if year==max_year
	gen year1=round(year)

	egen country_year = concat(countrycode year1), punct(_)
	levelsof country_year, local(levels)
		
		foreach l of local levels{
		
			cap restore
			preserve
			
			gen dataset = "`l'"
			keep if country_year=="`l'"
			sort y
			gen i=_n
				
			count
			local N=r(N)
				
			gen y_i = 0
				
			forvalues j=1(1)`N'{
				local k=`N'+1-`j'
					replace y_i = y[`k'] in `j'
			}

			gen Sy = sum(y)
			gen S_y = sum(y_i)

			gen temp_`l' = .

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
	save "${out}/`r'_`l'.dta", replace
	restore
	
	} // levels country_year
} // region


* Prepare Dataset by merging together all country_year dataset
*-------------------------------------------------------------------------------
set more off
use "${out}/Povcalnet/AFR1_AGO_2009.dta", clear
keep i

local files: dir "${out}/Povcalnet/"  files "*.dta"
foreach f in `files'{
merge 1:1 i using `"${out}/Povcalnet/`f'"', keepusing(temp)
drop _merge
rename temp_* *
}

foreach v of varlist _all{
replace `v' = `v'/10000
}
tempfile temp
save `temp'

* Add MEX_2010 and NIC_2005 that for some reason come with 20000 observations
use "${out}/LCN3_MEX_2010.dta", clear
keep i temp
merge 1:1 i using "${out}/LCN3_NIC_2005.dta", keepusing(temp)
drop _merge
foreach v of varlist _all{
replace `v' = `v'/20000
}
rename temp_* *

* keep only 10000 observations
gen n=_n
gen check = mod(n,2)
keep if check==0

merge 1:1 i using `temp'
gen test=i
drop check n _merge
save "${out}/PIC.dta", replace

                       
* Prepare PIC_I
*-------------------------------------------------------------------------------
preserve
collapse(sum) _all

foreach v of varlist _all{
replace `v' =`v' / 10000
replace `v' = (`v'* 2) - 1
}

drop i test
xpose, clear varname

rename v1 pic_i
rename _varname country_year
save "${out}/PIC_I.dta", replace
restore

