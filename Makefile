all: clean lint tests build-ios-all build-apk-all build-android-appbundle-production

#############################
#
#	DEVELOPMENT TASKS
#
#############################
feature:
	mason get
	mason make nk_riverpod_feature
	git add .

run:
	flutter run

run-release:
	flutter run --release

format:
	dart format . --set-exit-if-changed

format-fix:
	dart format .

lint:
	flutter analyze

tests:
	flutter test

packages-outdated:
	flutter pub outdated

packages-upgrade:
	flutter pub upgrade

clean:
	flutter clean
	flutter pub get
	make build-runner

build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs

build-runner-watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

generate-doc:
	dart doc

appicon-generate:
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml

splashscreen-generate:
	flutter pub run flutter_native_splash:create

#############################
#
#	BUILD CONFIGURATIONS
#
#############################

developmentFlavorName := development
stagingFlavorName := staging
productionFlavorName := production

build-ios-all: build-ios-prod build-ios-staging build-ios-development

build-ios-prod:
	@echo "Build iOS $(productionFlavorName)"
	flutter build ipa -t lib/main_$(productionFlavorName).dart --flavor $(productionFlavorName) --obfuscate --split-debug-info=./dist/ios-$(productionFlavorName)-debug-symbols/ --tree-shake-icons --export-options-plist=ios/ios-export-options-$(productionFlavorName).plist --suppress-analytics
	cp build/ios/ipa/interamt.ipa dist/interamt-$(productionFlavorName).ipa

build-ios-staging:
	@echo "Build iOS $(stagingFlavorName)"
	flutter build ipa -t lib/main_$(stagingFlavorName).dart --flavor $(stagingFlavorName) --obfuscate --split-debug-info=./dist/ios-$(stagingFlavorName)-debug-symbols/ --tree-shake-icons --export-options-plist=ios/ios-export-options-$(stagingFlavorName).plist --suppress-analytics
	cp build/ios/ipa/interamt.ipa dist/interamt-$(stagingFlavorName).ipa

build-ios-development:
	@echo "Build iOS $(developmentFlavorName)"
	flutter build ipa -t lib/main_$(developmentFlavorName).dart --flavor $(developmentFlavorName) --obfuscate --split-debug-info=./dist/ios-$(developmentFlavorName)-debug-symbols/ --tree-shake-icons --export-options-plist=ios/ios-export-options-$(developmentFlavorName).plist --suppress-analytics
	cp build/ios/ipa/interamt.ipa dist/interamt-$(developmentFlavorName).ipa
# Temporäre Lösung für die Builds während des Hackathons
build-ios-hackathon:
	@echo "Build iOS"
	flutter build ipa -t lib/main.dart --obfuscate --split-debug-info=./dist/ios-debug-symbols/ --tree-shake-icons --export-options-plist=ios/ios-export-options-development.plist --suppress-analytics
	cp build/ios/ipa/hackathon23.ipa dist/hackathon23.ipa

build-apk-all: build-android-apk-production build-android-apk-staging build-android-apk-development

build-android-apk-production:
	@echo "Build APK $(productionFlavorName)"
	flutter build apk -t lib/main_$(productionFlavorName).dart --flavor $(productionFlavorName) --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./dist/android-apk-$(productionFlavorName)-debug/
	cp build/app/outputs/apk/$(productionFlavorName)/release/app-$(productionFlavorName)-release.apk dist/interamt-$(productionFlavorName).apk

build-android-apk-staging:
	@echo "Build APK $(stagingFlavorName)"
	flutter build apk -t lib/main_$(stagingFlavorName).dart --flavor $(stagingFlavorName) --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./dist/android-apk-$(stagingFlavorName)-debug/
	cp build/app/outputs/apk/$(stagingFlavorName)/release/app-$(stagingFlavorName)-release.apk dist/interamt-$(stagingFlavorName).apk

build-android-apk-development:
	@echo "Build APK $(developmentFlavorName)"
	flutter build apk -t lib/main_$(developmentFlavorName).dart --flavor $(developmentFlavorName) --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./dist/android-apk-$(developmentFlavorName)-debug/
	cp build/app/outputs/apk/$(developmentFlavorName)/release/app-$(developmentFlavorName)-release.apk dist/interamt-$(developmentFlavorName).apk

build-android-appbundle-production:
	@echo "Build $(productionFlavorName) PlayStore App Bundle"
	flutter build appbundle -t lib/main_$(productionFlavorName).dart --flavor $(productionFlavorName) --obfuscate --split-debug-info=./dist/android-appbundle-$(productionFlavorName)-debug/
	cp build/app/outputs/bundle/$(productionFlavorName)Release/app-$(productionFlavorName)-release.aab dist/interamt-$(productionFlavorName).aab

#############################
#
#	FASTLANE RELEASE CONFIGURATION
#
#############################

release-ios:
	@echo "Release iOS"
	cd ios; bundle exec fastlane deploy

release-android:
	@echo "Release Android"
	cd android; bundle exec fastlane deploy