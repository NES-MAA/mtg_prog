PTX_HOME = /Users/joefields/Desktop/mathbook
JING_HOME = /Users/joefields/Desktop/jing-trang
BOOK_HOME = /Users/joefields/Desktop/mtg_prog

all: pdf html
pdf: pdf/program.pdf
html: html/program.html

pdf/program.pdf: pdf/program.aux
	cd pdf; pdflatex program

pdf/program.aux: pdf/program.tex
	cd pdf; pdflatex program

pdf/program.tex: src/*.ptx 
	cd pdf; test ! -e images && ln -s ../images images; cp ../xsl-stylesheets/program-latex.xsl ${PTX_HOME}/user/; xsltproc --xinclude ${PTX_HOME}/user/program-latex.xsl  ../src/program.ptx


html/program.html: src/*.ptx
	cd html; test ! -e images && ln -s ../images images; cp ../xsl-stylesheets/program-html.xsl ${PTX_HOME}/user/; xsltproc --xinclude ${PTX_HOME}/user/program-html.xsl ../src/program.ptx

clean::
	rm ./*~ ./*/*~ ./*/*.bak ./*.bak ./pdf/*.pdf ./pdf/*.aux ./pdf/*.tex ./pdf/*.out ./pdf/*.log ./pdf/images ./html/*.html ./html/images; rm -rf html/knowl/

check::
	java -classpath ${JING_HOME}/build/ -classpath ${JING_HOME}/lib/ -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration -jar ${JING_HOME}/build/jing.jar ${PTX_HOME}/schema/pretext.rng src/program.ptx > validation_errors.txt; less validation_errors.txt
