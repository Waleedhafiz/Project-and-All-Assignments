temp = list.files(pattern="*.csv")
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv), envir = .GlobalEnv)


df <- data.frame(detail_ball)


dff = df[df$batsman == 1186, ]


write.csv(dff, file = "Runs.csv")

df1 <- data.frame(detail_extra)

df2 <- data.frame(detail_runs)

df3 <- data.frame(detail_wicket)

df4 <- df1[df1$wides]

df5 <- df2[df2$batsman == 1186,]

df6 = df3[df3$batsman == 1186,]

write.table(dff, "Overall.csv", col.names=TRUE, sep=",")
write.table(df4, "Overall.csv", col.names=TRUE, sep=",", append=TRUE)
write.table(df5, "Overall.csv", col.names=FALSE, sep=",", append=TRUE)
write.table(df6, "Overall.csv", col.names=FALSE, sep=",", append=TRUE)

write.csv(rbind(df1, d32, df3),"Overall.csv")