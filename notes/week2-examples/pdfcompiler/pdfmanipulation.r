library(pdftools)
pdf_combine(c(
"1.pdf",
"2.pdf"
), 
output = "nam.pdf")

#extract some pages
pdf_subset('nam.pdf',pages = 1:1, output = "extract1.pdf")

