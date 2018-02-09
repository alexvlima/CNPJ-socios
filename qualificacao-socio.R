##############
#### PATH ####
##############

getwd()
setwd('~/Documents')

##############
## LIBRARY ###
##############

# install.packages("gdata")
# install.packages("pdftools")

library(pdftools)
library(gdata)

##############
## FUNCTION ##
##############

rm_accent <- function(str,pattern="all") {
  if(!is.character(str))
    str <- as.character(str)
  
  pattern <- unique(pattern)
  
  if(any(pattern=="Ç"))
    pattern[pattern=="Ç"] <- "ç"
  
  symbols <- c(
    acute = "áéíóúÁÉÍÓÚýÝ",
    grave = "àèìòùÀÈÌÒÙ",
    circunflex = "âêîôûÂÊÎÔÛ",
    tilde = "ãõÃÕñÑ",
    umlaut = "äëïöüÄËÏÖÜÿ",
    cedil = "çÇ"
  )
  
  nudeSymbols <- c(
    acute = "aeiouAEIOUyY",
    grave = "aeiouAEIOU",
    circunflex = "aeiouAEIOU",
    tilde = "aoAOnN",
    umlaut = "aeiouAEIOUy",
    cedil = "cC"
  )
  
  accentTypes <- c("´","`","^","~","¨","ç")
  
  if(any(c("all","al","a","todos","t","to","tod","todo")%in%pattern)) # opcao retirar todos
    return(chartr(paste(symbols, collapse=""), paste(nudeSymbols, collapse=""), str))
  
  for(i in which(accentTypes%in%pattern))
    str <- chartr(symbols[i],nudeSymbols[i], str)
  
  return(str)
}

##############
### ARCHIVE ##
##############

# Download do arquivo com a qualificacao do socio
download.file(url = "http://idg.receita.fazenda.gov.br/orientacao/tributaria/cadastros/cadastro-nacional-de-pessoas-juridicas-cnpj/Qualificacao_socio.pdf",
              destfile = "qualificacao-socio.pdf",
              method = "auto")


arquivo_txt <- pdf_text("qualificacao-socio.pdf")
arquivo_txt

temp <- strsplit(arquivo_txt, "\n")
# head(temp)
# tail(temp)
temp <- unlist(temp)
temp <- temp[c(-1,-2,-43)]
temp <- trim(temp)
# temp
qualificacao <- data.frame(substring(temp,1,2),
                                 substring(temp,3))
# View(qualificacao)
colnames(qualificacao) <- c("Codigo", "Descricao")
qualificacao$Codigo <- as.numeric(qualificacao$Codigo)

qualificacao$Descricao <- rm_accent(qualificacao$Descricao)
qualificacao$Descricao <- trim(qualificacao$Descricao)

##############
## WRITE CSV #
##############

write.csv2(qualificacao,"qualificacao-socio.csv",
           row.names = FALSE,
           fileEncoding = "UTF-8")
