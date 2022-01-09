#Please be careful for the order of *.mk
include $(MK_ENV_DIR)/host.mk
include $(MK_ENV_DIR)/build_env.mk

define fetch_remote
	pushd $(1);\
	echo Updating remote : $(2);\
	git fetch $(2);\
	popd
endef

define checkout_src
	rm -rf $(2); mkdir -p $(2);\
	pushd $(1);\
	echo Checking out branch: $(3) from $(1) to $(2);\
	if [ -f .gitattributes ] ; then \
		echo You may lose something because of .gitattributes in the worktree;\
	fi; \
	git archive --format=tar --worktree-attributes $(3) | (cd $(2) && tar xf -);\
	popd
endef

#$(1) repo
#$(2) remote _ brach
#$(3) local brach
#$(4) des_dir
#$(5) update remote or not
define checkout_src_full
	if [ -n "$(strip $2)" ] ; then \
		REMOTE=$(shell echo $2 | awk  '{print $$1}'); \
		BRANCH=$(shell echo $2 | awk  '{print $$2}'); \
		if [ -n "$5" ] ; then \
			$(call fetch_remote, $1, $$REMOTE) ;\
		fi; \
		if [ -z $$BRANCH ] ; then \
			BRANCH=master ;\
		fi; \
		echo Using remote branch: $$REMOTE/$$BRANCH;\
		$(call checkout_src, $1, $4, $$REMOTE/$$BRANCH) ;\
	else if [ -n "$(strip $3)" ] ; then \
		echo Using local branch: $3;\
		$(call checkout_src, $1, $4, $3) ;\
	else \
		echo source install error! ;\
		exit 1;\
	fi; fi
endef

#$(1) binary
#$(2) des_dir
#$(3) cp args
#$(4) rename
define install_bin
	install -d $(2);\
	cp $(3) $(1) $(2);\
	if [ -n "$(4)" ] ; then \
		mv $(2)/$(notdir $(1)) $(join $(2)/, $(4)) ;\
	fi;\
	sync;\
	tree --timefmt "%Y/%m/%d %H:%M:%S" $(2)
endef

#$(1) binaries list
#$(2) des_dir
#$(3) cp args
define install_bins
	install -d $(2); \
	for binary in $(1); do \
		cp $(3) $$binary $(2); \
	done; \
	sync; \
	tree --timefmt "%Y/%m/%d %H:%M:%S" $(2)
endef

#$(1) dir
#$(2) evn
#$(3) targets
define build_target
	pushd $(1);\
	$(2) $(MAKE) $(3);\
	popd
endef

define build_target_log
	LOG_DIR=$(join $(SDK_LOG_DIR)/,$(notdir $(1)));\
	BUILD_LOG=$(join $$LOG_DIR/,$(SDK_BUILD_LOG));\
	ERROR_LOG=$(join $$LOG_DIR/,$(SDK_ERROR_LOG));\
	mkdir -p $$LOG_DIR;\
	cd $(1);\
	$(2) $(MAKE) $(3) \
	1>$$BUILD_LOG \
	2>$$ERROR_LOG;\
	whiptail \
	--title "Build Log" \
	--yesno "Build result: $$? \n\
	Buildlog: $$BUILD_LOG;\n\
	Errorlog: $$ERROR_LOG;\n\
	\nDo you want to check the logs?" \
	20 60 && vim $$BUILD_LOG $$ERROR_LOG;\
	echo ========================;\
	echo Buildlog: $$BUILD_LOG;\
	echo Errorlog: $$ERROR_LOG;\
	echo ========================;\
	cd -
endef

define devel_init
	cd $(1); ctags -R .;\
	if [ ! -d .git ] ; then \
		echo $(1) is NOT a git repo, init git info. ;\
		git init; git add .; git commit -m "init" ;\
	else \
		echo $(1) is already a git repo. ;\
	fi; \
	cd -
endef

