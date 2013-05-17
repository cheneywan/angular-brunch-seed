.PHONY : server build optimize update clean pull deploy unlimit npmupdate
.IGNORE : deploy

brunchPath=node_modules/brunch/bin/brunch

define allowBreak
	trap 'exitprocess' 2;\
	function exitprocess() { exit 127; };
endef

server : unlimit clean
	@echo "开始监视目录变动..."
	@$(allowBreak)\
	DEBUG=brunch:* $(brunchPath) watch --server;\
	if [ $$? -ne 0 -a $$? -ne 127 ]; then\
		echo "启动失败，正在重新开始...";\
		make server;\
	fi;

build : unlimit clean
	@echo "开始构建项目文件..."
	@$(allowBreak)\
	DEBUG=brunch:* $(brunchPath) build;\
	if [ $$? -ne 0 -a $$? -ne 127 ]; then\
		make build;\
	fi;

optimize : unlimit clean
	@echo "开始构建并压缩项目文件..."
	@$(allowBreak)\
	$(brunchPath) build --optimize;\
	if [ $$? -ne 0 -a $$? -ne 127 ]; then\
		make optimize;\
	fi;

deploy :
	@echo "开始检查是否存在新的 Commit ...";
	@sh ./scripts/compare_remote_hash.sh;\
	if [ $$? -eq 1 ]; then\
		echo "远程分支存在新的 Commit ，开始更新...";\
		make pull;\
		make npmupdate;\
		make optimize;\
	fi;
	@echo "Deploy at time "`date '+%Y-%m-%d %H:%M:%S'` >> deploy.log;

pull :
	@echo "开始检查是否存在新的 Commit ...";
	@sh ./scripts/compare_remote_hash.sh;\
	if [ $$? -eq 1 ]; then\
		echo "远程分支存在新的 Commit ，开始更新...";\
		git pull --force;\
		make submoduleupdate;\
	fi

update :
	@echo "开始更新子仓库..."
	@-git submodule foreach "git checkout master || git checkout gh-pages"
	@-git submodule foreach "git pull"

npmupdate :
	@echo "开始更新插件..."
	@npm install

submoduleupdate :
	@echo "开始同步子仓库..."
	@-git submodule init
	@-git submodule update

unlimit :
	@echo "开始调整系统最大文件打开数..."
	@-ulimit -n 10000

clean :
	@echo "开始清理目录..."
	@-rm -rf public
