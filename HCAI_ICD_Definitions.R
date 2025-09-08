##################################################################################
###             
###  Classifying ICD-9 and ICD-10 Diagnostic Codes from HCAI ED Visit Data          
###
###################################################################################
###
### purpose: This code is used to define Department of Health Care Access and Information (HCAI) ICD-9 and ICD-10 to diagnostic codes 
### for use to estimate effects of heat on emergency department visits in California at ZIP code-level. 
###  
### author: Code written and organized by Marinelle Villanueva
### date: 2025-08-31
### ICD-9 & 10 Diagnostic Codes: https://data.chhs.ca.gov/dataset/hospital-emergency-department-diagnosis-procedure-and-external-cause-codes
###
###################################################################################

### ICD-9 Classifications
patternsICD9 <- list(
  infect = '^00[1-9]',        # intestinal infectious diseases
  dehydration = '27651',      # dehydration
  urinary = '^584|^585|^586', # renal failure
  heat = '^992'               # heat illness and heat stroke
)

condition_functions09 <- setNames(
  lapply(patternsICD9, function(pattern1) {
    function(row) grepl(pattern1, row)
  }),
  names(patternsICD9)
)

# ICD-9 Sub Classifications
patternsICD9subs <- list(
  ihd = '^41[1-4]',      # ischemic heart disease
  cd = '^427',           # cardiac dysrhythmias 
  hypo = '^458',         # hypotension
  istroke = '^43[3-6]',  # ischemic stroke
  pneu = '^48[0-6]',     # pneumonia
  diab = '^250',         # diabetes
  arf = '^584|^586')     # acute renal failure

condition_functions09_subs <- setNames(
  lapply(patternsICD9subs, function(pattern1) {
    function(row) grepl(pattern1, row)
  }),
  names(patternsICD9subs)
)

rm(patternsICD9, patternsICD9subs) # remove data frames no longer needed

### ICD-10 Classifications
patternsICD10 <- list(
  infect = '^(A00|A0[1-9])', # intestinal infectious disease 
  dehydration= 'E860',       # dehydration
  urinary = '^N1[7-9]',      # renal failure
  heat = '^T67'              # heat illness and heat stroke
)

condition_functions10 <- setNames(
  lapply(patternsICD10, function(pattern3) {
    function(row) stringr::str_detect(row, pattern3)
  }),
  names(patternsICD10)
)

# ICD-10 Sub Classifications
patternsICD10subs <- list(
  ihd = '^I20|^I2[2-5]',            # ischemic heart disease
  cd = '^I4[7-9]',                  # cardiac dysrhythmias 
  hypo = '^I95',                    # hypotension
  istroke = '^I6[3-6]|^G45|I6789',  # added G45, 16789; excluded I67
  pneu = '^J1[2-8]',                # pneumonia
  diab = '^E08|^E09|^E1[0-1]|^E13', # diabetes
  arf = '^N17|^N19')                # acute renal failure

condition_functions10_subs <- setNames(
  lapply(patternsICD10subs, function(pattern3) {
    function(row) stringr::str_detect(row, pattern3)
  }),
  names(patternsICD10subs)
)

rm(patternsICD10, patternsICD10subs) # remove data frames no longer needed