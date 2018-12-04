CC		:= gcc
DEBUG		:= -g
CFLAGS		:= -c -Wall $(DEBUG)
CURRENT_DIR	:= $(shell pwd)

PACKAGE_VERSION	:= 0.12.1
PACKAGE_DIR	:= json-c-$(PACKAGE_VERSION)
PACKAGE_CONF	:= \
	--prefix=$(CURRENT_DIR)	\
        ac_cv_func_malloc_0_nonnull=yes \
        ac_cv_func_memcmp_working=yes \
        ac_cv_func_realloc_0_nonnull=yes

SOURCE_DIR	:= src
EXAMPLE_DIR	:= SampleTestProgram
INCLUDE_DIR	:= include
LIBRARY_DIR	:= lib

LIBS := -ljson-c -Wl,-rpath=$(CURRENT_DIR)/$(LIBRARY_DIR)
	
.PHONY: all clean

DEPS = $(patsubst %,$(INCLUDE)/%,$(_DEPS))

all : extractJson jsonlib

extractJson :
	if [ ! -d "$(CURRENT_DIR)/$(PACKAGE_DIR)" ];then \
		tar -zxvf $(PACKAGE_DIR).tar.gz;	\
	fi

jsonlib :
	cd $(CURRENT_DIR)/$(PACKAGE_DIR);	\
	./autogen.sh;	\
	./configure $(PACKAGE_CONF);	\
	$(MAKE) install

distclean: clean
	rm -rf $(CURRENT_DIR)/$(PACKAGE_DIR);

clean :
	cd $(CURRENT_DIR)/$(PACKAGE_DIR) && $(MAKE) clean;	\
	rm -rf $(CURRENT_DIR)/$(INCLUDE_DIR);	\
	rm -rf $(CURRENT_DIR)/$(LIBRARY_DIR);
