Note on mandatory fields with lists (but not strings): also HL7 NULL flavors will be allowed.

Version history; Items added per version

| Items                                          | Date version release | Version number |
| ---------------------------------------------- | -------------------- | -------------- |
| GoE_minimal_metadata_on_AF-browser_dataset_submission | 2025-11-05           | v1.0           |

Decision(s):

| Decision                   | Date decision | Motivation/Information                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| dct:accessRights -> PUBLIC | 2025-11-05    | All the data/information in the AF-browser (beacon) will be at aggregated level and therefore can be made available under the PUBLIC accessRights value. The table is prepopulated with this value. For subject level data (outside the scope of this exercise), which contains personal data, the correct access level is 'NON_PUBLIC'. If for the same subjects subject level data and aggregated data (vcf) is to be made available, two instances of the Dataset have to be described, one describing the subject level data under access level NON_PUBLIC, one describing the aggregated data under access level PUBLIC. |
