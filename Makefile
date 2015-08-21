forms=$(wildcard *.commonform)
json=$(forms:commonform=json)
COMMONFORM=node_modules/.bin/commonform

all: $(json)

$(COMMONFORM):
	npm i --save commonform-cli

%.json: %.commonform $(COMMONFORM)
	$(COMMONFORM) render --format native < $< > $@

.PHONY: clean share

clean:
	rm -rf $(json)

share: $(json)
	for json in $(json); do \
		commonform share < $$json; \
	done
