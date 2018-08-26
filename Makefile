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
	cd pdf; test ! -e photos && ln -s ../photos photos; xsltproc --xinclude ${PTX_HOME}/xsl/mathbook-latex.xsl ../src/program.ptx


html/program.html: src/*.ptx
	cd html; test ! -e photos && ln -s ../photos photos; xsltproc --stringparam html.css.extra extra.css --stringparam html.knowl.example.inline no --stringparam html.knowl.exercise.inline no --xinclude ${PTX_HOME}/xsl/mathbook-html.xsl ../src/program.ptx

clean::
	rm ./*~ ./*/*~ ./*/*.bak ./*.bak ./pdf/*.pdf ./pdf/*.aux ./pdf/*.tex ./pdf/*.out ./pdf/*.log ./pdf/photos ./html/*.html ./html/photos; rm -rf html/knowl/

check::
	java -classpath ${JING_HOME}/build/ -classpath ${JING_HOME}/lib/ -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration -jar ${JING_HOME}/build/jing.jar ${PTX_HOME}/schema/pretext.rng src/program.ptx > validation_errors.txt; less validation_errors.txt
