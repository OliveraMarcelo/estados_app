# cspell:disable
.DEFAULT_GOAL := help
.PHONY: help build run serve test clean release commit pull-dev deploy-dev

help:  ## 📖 Muestra esta ayuda / Show this help
	@fgrep -h "  ##" $(MAKEFILE_LIST) | fgrep -v fgrep | sort | sed -e 's/\\$$//' | sed -e 's/^# //' | sed -e 's/##//'

# ------------------------------------------------------------------------------------------------------------------
# Configuración de entorno / Environment configuration

WEB_HOSTNAME   ?= localhost
WEB_PORT       ?= 4444

APPNAME        ?= sarmiento
APPTITLE       ?= Sarmiento
APP_ID_WEB     ?= com.exo.sarmiento.web

INTEGRATION_TEST_DRIVER           ?= test_driver/integration_test.dart
INTEGRATION_TEST_WEB_DEFAULT_FILE ?= integration_test/all_test.dart

CHROMEDRIVER_VERSION ?= 113.0.5672.63
CHROMEDRIVER_ARCH    ?= linux64
CHROMEDRIVER_PORT    ?= 4444

RELEASE_TARGETS = --releaseweb
RELEASE_FOLDERS = build/web
RELEASE_INCLUDE = LICENSE

# ------------------------------------------------------------------------------------------------------------------
# Comandos Flutter / Flutter Commands

build:  ## 🔨 Compila la app web / Build Flutter web
	@echo "🔨 Compilando app web..."
	flutter build web
	@echo "✅ Build web finalizado."

run:  ## 🚀 Ejecuta la app con hot reload / Run Flutter web (hot reload)
	@echo "🚀 Ejecutando app en modo hot reload..."
	flutter run -d chrome --web-port=$(WEB_PORT) --web-hostname=$(WEB_HOSTNAME)

serve:  ## 🌐 Sirve la web desde build/ / Serve Flutter web (static)
	@echo "🌐 Sirviendo web desde carpeta build/web en http://$(WEB_HOSTNAME):$(WEB_PORT)"
	python3 -m http.server $(WEB_PORT) --directory build/web
build-serve: build serve  ## 🔄 Compila y sirve la app web / Build and serve Flutter web

test:  ## 🧪 Ejecuta tests de integración web / Run Flutter integration tests for web
	@echo "🧪 Ejecutando tests de integración web..."
	flutter drive \
		--driver=$(INTEGRATION_TEST_DRIVER) \
		--target=$(INTEGRATION_TEST_WEB_DEFAULT_FILE) \
		--browser-name=chrome

test-chrome:  ## 🌐 Ejecuta tests de integración en Chrome / Run integration tests in Chrome
	@echo "🚀 Ejecutando tests de integración en Chrome..."
	@flutter config --enable-web
	@flutter pub get
	@flutter test integration_test/app_test.dart \
		--platform chrome \
		--web-browser-flag="--disable-web-security" \
		--web-browser-flag="--disable-features=VizDisplayCompositor" \
		--web-browser-flag="--no-sandbox" \
		--web-browser-flag="--disable-dev-shm-usage" \
		--web-browser-flag="--disable-gpu" \
		--web-browser-flag="--window-size=1920,1080" \
		--timeout 180s \
		--verbose
	@echo "✅ Tests de integración completados." \
		--web-port=$(CHROMEDRIVER_PORT)

clean:  ## 🧹 Limpia la build de Flutter / Clean Flutter build
	@echo "🧹 Limpiando archivos de build..."
	flutter clean
	@echo "✅ Proyecto limpio."

release: build  ## 📦 Empaqueta la versión de producción / Package web release version
	@echo "📦 Empaquetando versión de producción web..."
	tar -czf $(APPNAME)-web-release.tar.gz $(RELEASE_FOLDERS) $(RELEASE_INCLUDE)
	@echo "✅ Paquete creado: $(APPNAME)-web-release.tar.gz"

# ------------------------------------------------------------------------------------------------------------------
# Comandos GIT / GIT Commands
pull:
	@if [ -z "$(branch)" ]; then \
		echo "❌ Error: Debes proporcionar un nombre de rama con branch=\"nombre\""; \
		exit 1; \
	fi
	@echo "🔄 Haciendo pull desde rama $(branch)..."
	git pull origin $(branch)
	@echo "✅ Pull finalizado."
commit:  ## 💾 Crea un commit con mensaje / Make a commit with message (msg="message")
	@if [ -z "$(msg)" ]; then \
		echo "❌ Error: Debes proporcionar un mensaje de commit con msg=\"mensaje\""; \
		exit 1; \
	fi
	@echo "💾 Agregando cambios y realizando commit..."
	git add .
	git commit -m "$(msg)"
	git push
	@echo "✅ Commit realizado y cambios subidos."

pull-dev:  ## 🔄 Hace pull desde rama dev / Pull from dev branch
	@echo "🔄 Haciendo pull desde rama dev..."
	git pull origin dev
	@echo "✅ Pull finalizado."

deploy-dev:  ## 🚀 Mergea la rama actual a dev y pushea / Merge current branch into dev and push
	@branch=$$(git rev-parse --abbrev-ref HEAD); \
	echo "🚀 Mergeando rama $$branch a dev..."; \
	git checkout dev; \
	git pull origin dev; \
	git pull origin $$branch; \
	git push origin dev; \
	echo "✅ Deploy a dev realizado."

tag:  ## 🏷️ Crea un nuevo tag / Create a new tag
	@if [ -z "$(tag_name)" ]; then \
		echo "❌ Error: Debes proporcionar un nombre de tag con tag_name=\"nombre\""; \
		exit 1; \
	fi
	@echo "🏷️ Creando nuevo tag: $(tag_name)..."
	git tag $(tag_name)
	git push origin $(tag_name)
	@echo "✅ Tag creado: $(tag_name)"

create-feature:  ## 🚧 Crea una nueva rama feature (branch="nombre")
	@if [ -z "$(branch)" ]; then \
		echo "❌ Error: Debes pasar un nombre con branch=\"nombre\""; \
		exit 1; \
	fi
	git checkout -b feature/$(branch)
	git push --set-upstream origin feature/$(branch)
status:  ## 📋 Muestra el estado de Git
	git status
log:  ## 📜 Muestra el log de commits
	git log --oneline --graph --all --decorate
diff:  ## 🔍 Muestra diferencias sin commitear
	git diff
diff-staged:  ## 🔍 Muestra diferencias en staged
	git diff --cached
tag-latest:  ## 🏷️ Muestra el último tag
	git describe --tags --abbrev=0
