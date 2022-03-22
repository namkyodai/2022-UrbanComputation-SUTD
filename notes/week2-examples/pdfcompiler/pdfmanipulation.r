library(pdftools)
pdf_combine(c(
"../../../references/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf",
"../../../references/tidy-data.pdf"
), 
output = "output.pdf")

#extract some pages
pdf_subset('output.pdf',pages = 1:1, output = "extract.pdf")

