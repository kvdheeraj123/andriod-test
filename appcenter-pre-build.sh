#!/usr/bin/env bash
APP_VERSION="22.27.00"

echo $(Build.SourceBranchName)

exit 0

##################### jul 2 2022 addition
echo "#############################"
echo "verifying if branch is a feature branch"
SUBSTRING='feature'
if [[ "$APPCENTER_BRANCH" == *"$SUBSTRING"* ]]; then
  echo "It's a feature branch."
  else
  echo "$APPCENTER_BRANCH - It's NOT a feature branch. "
fi
echo "app version: $APP_VERSION"
echo "if feature branch app version will be: feature/$APP_VERSION"
echo "if feature branch  TARGET_PATH_URL will be: environments/feature.json"
echo "enable buld time print in seconds"
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES
echo "#############################"
##################### jul 2 2022 addition

#############################
echo "ENV variables will come from below"
echo $TARGET_PATH_URL

cp $TARGET_PATH_URL $ENV_FILE_PATH

echo "Set env variables from appcenter configurations to mobile app source code:"
echo "-Set AWS_ACCESS_KEY_ID"
sed -i "" "/AWS_ACCESS_KEY_ID/s/.*/  \"AWS_ACCESS_KEY_ID\": \""$AWS_ACCESS_KEY_ID"\",/" $ENV_FILE_PATH
echo "-Set AWS_SECRET_ACCESS_KEY"
sed -i "" "/AWS_SECRET_ACCESS_KEY/s/.*/  \"AWS_SECRET_ACCESS_KEY\": \""$AWS_SECRET_ACCESS_KEY"\",/" $ENV_FILE_PATH

yarn switch-app

if [[ ! -z "$APPCENTER_ANDROID_VARIANT" ]]
then
  # Android manifest path
  MANIFEST_PATH="$APPCENTER_SOURCE_DIRECTORY/android/app/src/main/AndroidManifest.xml"
  BUILD_GRADLE_PATH="$APPCENTER_SOURCE_DIRECTORY/android/app/build.gradle"
fi

# Get the proper bundle name and identifier and apply it to the info.plist
case $TARGET_ENV in
  dev)
    echo -n "Inserting DEV ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME='WithMe DEV'
    ENV_BUNDLE_IDENTIFIER='com.withme.membermobile.dev'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-n4vfkb85ddskhm4g8933gul1eqdp44nu.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-n4vfkb85ddskhm4g8933gul1eqdp44nu'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:fda2ab8c4df512f83a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.withme.membermobile'
    ;;
  dev_navitus)
    echo -n "Inserting NAVITUSplus DEV ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME='NAVITUSplus DEV'
    ENV_BUNDLE_IDENTIFIER='com.withme.navitus.membermobile.dev'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-n4vfkb85ddskhm4g8933gul1eqdp44nu.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-n4vfkb85ddskhm4g8933gul1eqdp44nu'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:fda2ab8c4df512f83a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.oktapreview.navitus'
    ;;
  test)
    echo -n "Inserting QA ENV bundle name and bundle identifier\n "
    ENV_BUNDLE_NAME='WithMe QA'
    ENV_BUNDLE_IDENTIFIER='com.withme.membermobile.qa'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-h37f18h4q360ig3mt8nnb18o78tuve25.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-h37f18h4q360ig3mt8nnb18o78tuve25'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:7916699630afdc023a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.withme.membermobile'
    ;;
  test_navitus)
    echo -n "Inserting QA ENV bundle name and bundle identifier\n  "
    ENV_BUNDLE_NAME='NAVITUSplus QA'
    ENV_BUNDLE_IDENTIFIER='com.withme.navitus.membermobile.qa'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-h37f18h4q360ig3mt8nnb18o78tuve25.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-h37f18h4q360ig3mt8nnb18o78tuve25'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:7916699630afdc023a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.oktapreview.navitus'
    ;;
  demo)
    echo -n "Inserting Demo ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME='WithMe Demo'
    ENV_BUNDLE_IDENTIFIER='com.withme.membermobile.demo'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-29lhnu6djhfls6cihpqb9rr2ltcgkhub.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-29lhnu6djhfls6cihpqb9rr2ltcgkhub'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:471ae68767f22ae03a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.withme.membermobile'
    ;;
  demo_navitus)
    echo -n "Inserting Demo ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME='NAVITUSplus Demo'
    ENV_BUNDLE_IDENTIFIER='com.withme.navitus.membermobile.demo'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-29lhnu6djhfls6cihpqb9rr2ltcgkhub.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-29lhnu6djhfls6cihpqb9rr2ltcgkhub'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:471ae68767f22ae03a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.oktapreview.navitus'
    ;;
  uat)
    echo -n "Inserting UAT ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME="WithMe UAT"
    ENV_BUNDLE_IDENTIFIER='com.withme.membermobile.uat'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:91c647643ffa5f263a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.withme.membermobile'
    ;;
  uat_navitus)
    echo -n "Inserting UAT ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME="NAVITUSplus UAT"
    ENV_BUNDLE_IDENTIFIER='com.navitus.membermobile.uat'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:91c647643ffa5f263a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.oktapreview.navitus'
    ;;
  production)
    echo -n "Inserting Production ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME="WithMe"
    ENV_BUNDLE_IDENTIFIER='com.withme.membermobile.production'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:91c647643ffa5f263a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.withme.membermobile'
    ;;
  production_navitus)
    echo -n "Inserting Production ENV bundle name and bundle identifier\n"
    ENV_BUNDLE_NAME="NAVITUSplus"
    ENV_BUNDLE_IDENTIFIER='com.navitus.membermobile.prod'
    IOS_GOOGLE_SERVICES_CLIENT_ID='182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm.apps.googleusercontent.com'
    IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID='com.googleusercontent.apps.182299784422-fjf5uel7u8suhvsdnr8vrisa6luc89rm'
    IOS_GOOGLE_SERVICES_GOOGLE_APP_ID='1:182299784422:ios:91c647643ffa5f263a3727'
    ANDROID_AUTH_MANIFEST_PLACEHOLDER='com.okta.navitus-ext'
    ;;
  *)
    echo -n "NO BUNDLE IDENTIFIER OR NAME MATCHED  \n"
    ;;
esac

# Add NAVITUSplus Specific Assets to the build if the build is for navitus
# below condition uses wildcard to match for navitus
if [[ "$TARGET_ENV" == *"navitus"* ]]
then
  # ios white-labeled binary assets
  echo "\n Inserting assets for NAVITUSplus White Label App for Binary"
  # android white-labeled binary assets
  #TODO: Insert a script to do that here

else
  echo "\n Default binary assets will be used"
fi

# Add the appcenter secret to the build

if [[ ! -z "$APPCENTER_XCODE_PROJECT" ]]
then
  # ios
  plutil -replace AppSecret -string "$TARGET_APPCENTER_KEY" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/AppCenter-Config.plist
  plutil -replace CFBundleName -string "$ENV_BUNDLE_NAME" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/Info.plist
  plutil -replace CFBundleDisplayName -string "$ENV_BUNDLE_NAME" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/Info.plist
  plutil -replace CFBundleIdentifier -string "$ENV_BUNDLE_IDENTIFIER" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/Info.plist
  plutil -replace CFBundleVersion -string "$APP_VERSION" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/Info.plist
  plutil -replace CFBundleShortVersionString -string "$APP_VERSION" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/Info.plist
  plutil -replace SegmentWriteKey -string "$SEGMENT_WRITE_KEY" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/Info.plist

  # for google_services (Push Notifications on iOS via react-native-firebase)
  plutil -replace CLIENT_ID -string "$IOS_GOOGLE_SERVICES_CLIENT_ID" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/GoogleService-Info.plist
  plutil -replace REVERSED_CLIENT_ID -string "$IOS_GOOGLE_SERVICES_REVERSED_CLIENT_ID" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/GoogleService-Info.plist
  plutil -replace GOOGLE_APP_ID -string "$IOS_GOOGLE_SERVICES_GOOGLE_APP_ID" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/GoogleService-Info.plist
  plutil -replace BUNDLE_ID -string "$ENV_BUNDLE_IDENTIFIER" $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/GoogleService-Info.plist

  cat $APPCENTER_SOURCE_DIRECTORY/ios/WithMe/AppCenter-Config.plist
fi

if [[ ! -z "$APPCENTER_ANDROID_VARIANT" ]]
then
  # android appsecret key
  sed -i "" "s/appsecretvalue/$TARGET_APPCENTER_KEY/g" $APPCENTER_SOURCE_DIRECTORY/android/app/src/main/assets/appcenter-config.json

  # set the android versionCode and versionName in the AndroidManifest.xml

  sed -i "" 's/android:versionCode="[^"]*"/android:versionCode="'$APPCENTER_BUILD_ID'"/' $MANIFEST_PATH
  sed -i "" 's/android:versionName="[^"]*"/android:versionName="'$APP_VERSION'"/' $MANIFEST_PATH
  sed -i "" 's/MANIFEST_SCHEME_PLACEHOLDER/'$ANDROID_AUTH_MANIFEST_PLACEHOLDER'/' $BUILD_GRADLE_PATH

  cat $APPCENTER_SOURCE_DIRECTORY/android/app/src/main/assets/appcenter-config.json
fi
