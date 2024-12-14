# CdT-Progetto
Progetto per l'esame di Codifica di Testi (A.A. 2023/2024), realizzato da Serena Di Miceli [MAT. 635061], studentessa del corso di laurea triennale di Informatica Umanistica.
# Validazione XML:
```
java -cp "xerces-2_12_1/*" dom.Counter -v progetto.xml
```
# Trasformazione attraverso XSLT:
```
java -jar "./SaxonHE10-3J/saxon-he-10.3.jar" -s:progetto.xml -xsl:stile.xsl -o:progetto.html
```
