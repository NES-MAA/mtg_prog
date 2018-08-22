PTX_HOME = /Users/joefields/Desktop/mathbook
JING_HOME = /Users/joefields/Desktop/jing-trang
BOOK_HOME = /Users/joefields/Desktop/mtg_prog

all: svg pdf html
pdf: pdf/program.pdf
html: html/program.html

svg::
	${PTX_HOME}/script/mbx -vv -c latex-image -f svg -i ${BOOK_HOME}/figures -d ./html/images/ ./ptx/program.ptx

pdf/program.pdf: pdf/program.aux
	cd pdf; pdflatex program

pdf/program.aux: pdf/program.tex
	cd pdf; pdflatex program

pdf/program.tex: *.ptx images
	cd pdf; test ! -e photos && ln -s ../photos;  test ! -e figures && ln -s ../figures; xsltproc --xinclude ${PTX_HOME}/xsl/mathbook-latex.xsl ../ptx/program.ptx


html/program.html: ./src/*.ptx
	cd html; test ! -e photos && ln -s ../photos; test ! -e figures && ln -s ../figures; xsltproc --stringparam html.css.extra extra.css --stringparam html.knowl.example.inline no --stringparam html.knowl.exercise.inline no --xinclude ${PTX_HOME}/xsl/mathbook-html.xsl ../ptx/program.ptx

clean::
	rm *.aux *~ *.bak */*.aux */*~ */*.bak pdf/*.pdf html/*.html

check::
	java -classpath ${JING_HOME}/build/ -classpath ${JING_HOME}/lib/ -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration -jar ${JING_HOME}/build/jing.jar ${PTX_HOME}/schema/pretext.rng ptx/program.ptx > validation_errors.txt; less validation_errors.txt
