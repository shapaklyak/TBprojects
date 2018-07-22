*Purpose: To create summary odds ratio for TB slum meta-analysis

import delimited "filename", clear

*sputum smear positive
metan pop1slumtb pop1 pop2nonslumtb pop2, or xlab(.1,1,10) label (namevar=authorshort)

**sputum smear positive & active case finding
generate acfum = acfperarticle
encode acfum, generate (acf2)
metan pop1slumtb pop1 pop2nonslumtb pop2 if acf2==2, or xlab(.1,1,10) label (namevar= authorshort)

**sputum smear positive & HIV coinfection  
generate hiv = hivtblinked
encode hiv, generate (hiv2)
tab hiv2
tab hiv2, nolabel
metan pop1slumtb pop1 pop2nonslumtb pop2 if hiv2==3, or xlab(.1,1,10) label (namevar= authorshort)

Additional analyses:
*to estimate influence of individual studies on summary effect estimate
metainf logor selogor, eform id (authorshort)

*test for bias at eaach level of analysis
generate logor=log((pop1slumtb/pop1)/(pop2nonslumtb/pop2))
generate selogor=sqrt((1/pop1slumtb)+(1/pop1)+(1/pop2nonslumtb)+ (1/pop2))
meta logor selogor, eform graph(r) cline xline(1)xlab(.1,1,10) id(authorshort) b2title(Odds ratio) print

metabias logor selogor, graph(begg)

metabias logor selogor if acf2==2, graph(begg)

metabias logor selogor if hiv2==3, graph(begg)
