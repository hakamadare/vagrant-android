node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  $platforms   = prefix('android-', $::android_platforms)
  $build_tools = prefix('build-tools-', $::android_build_tools)

  # Install JDK
  class { 'java': } ->

  # Install Android SDK
  class { 'android': } ->

  # Install platform and build tools
  android::platform { $platforms: } ->
  android::build_tools { $build_tools: }

}
# vim: set ft=puppet ts=2 sw=2 ei:
