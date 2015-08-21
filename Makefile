forms=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform

all: $(forms:commonform=json)

$(COMMONFORM):
	npm i --save commonform-cli

%.json: %.commonform $(COMMONFORM)
	$(COMMONFORM) render --format native < $< > $@
