library(XML)

fileURL <-"http://olx.com.pk/lahore/mobile-phones/?page=1"
for (i in 1:500) {
  if (i > 1) {
    fileURL <-"http://olx.com.pk/lahore/mobile-phones/?page="
    fileURL <- paste(fileURL, i, sep = "")
  }
  doc <- htmlTreeParse(fileURL, useInternal = TRUE)
  Product_Title <- xpathSApply(doc, "//h3[@class='large lheight20 margintop10']/a/span", xmlValue)
  Href <- xpathSApply(doc, "//h3[@class='large lheight20 margintop10']/a", xmlGetAttr, 'href')
  
  Product_Price <- xpathSApply(doc, "//p[@class='price x-large margintop10']/strong", xmlValue)

  Category <- xpathSApply(doc, "//small[@class='breadcrumb small']", xmlValue)

  dateOfAdd <- xpathSApply(doc, "//td[@valign='bottom']/p", xmlValue)

  
  dfrm <- data.frame(Product_Title = Product_Title, Product_Price = Product_Price, Category = Category,
                     Date_Of_Add = dateOfAdd, Details_Link = Hrefs)
  
  if (i == 1) {
    write.table(dfrm, file = "Detail_links.csv", sep = ",", row.names = FALSE)
  }
  else {
    write.table(dfrm, file = "Detail_links.csv", append = TRUE, sep = ",", row.names = FALSE, col.names=FALSE)
  }
  
}