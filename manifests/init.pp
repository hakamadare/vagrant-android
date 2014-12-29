node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # quash an annoying warning
  Package {
    allow_virtual => true
  }

  # Install JDK
  class { 'java': } ->

  # Install Android SDK
  class { 'android': }

  $platforms   = prefix(hiera('android_platforms'), 'android-')
  $build_tools = prefix(hiera('android_build_tools'), 'build-tools-')

  # Install platform and build tools
  android::platform { $platforms: } ->
  android::build_tools { $build_tools: }

}
# vim: set ft=puppet ts=2 sw=2 ei:
