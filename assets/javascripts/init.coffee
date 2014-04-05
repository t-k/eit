doc = document
win = window
title = doc.getElementsByTagName("title")

if typeof console is "undefined"
  console = {}
  console.log = ->
    return

uaType = ->
  self = this
  ua = win.navigator.userAgent
  msie = ua.indexOf("MSIE ")
  self.iPhone = (ua.indexOf("iPhone") isnt -1 or ua.indexOf("iPod") isnt -1)
  self.iPad = ua.indexOf("iPad") isnt -1
  self.Android2 = (ua.indexOf("Android 2.") isnt -1)
  self.Android4 = (ua.indexOf("Android 4.") isnt -1)
  self.Android = ((ua.indexOf("Android") isnt -1) and (ua.indexOf("Mobile") isnt -1)) and (ua.indexOf("SC-01C") is -1)
  self.AndroidTab = (ua.indexOf("Android") isnt -1) and ((ua.indexOf("Mobile") is -1) or (ua.indexOf("SC-01C") isnt -1))
  self.WindowsPhone = (ua.indexOf("IEMobile") isnt -1 or ua.indexOf("ZuneWP") isnt -1)
  self.PC = (typeof win.orientation is "undefined")
  self.IE = (ua.indexOf("MSIE ") isnt -1)
  self.IEver = (parseInt(ua.substring(msie + 5, ua.indexOf(".", msie))))
  self.MOBILE = (self.iPhone or self.iPad or (ua.indexOf("Android") isnt -1) or self.WindowsPhone)
  self.SMART = (self.iPhone or self.Android or self.WindowsPhone)
  self.ua = ua
  return

ua = new uaType()

if typeof (String::trim) is "undefined"
  String::trim = ->
    String(this).replace /^\s+|\s+$/g, ""

setTitle = ->
  base = I18n.t("common.site_name")
  $title = $("#title")
  $source = $(".meta-title-source", "#container")
  source = $source and $source.text() or document.metaTitle
  if source
    title = source + " | " + base
    $title.text title.trim()

setDescription = ->
  base = I18n.t("common.site_desc")
  $desc = $("#meta-og-desc,#meta-desc")
  $source = $(".meta-desc-source", "#container")
  if $source.length > 0
    source = ""
    _.each $source, (v, k) ->
      source = source + " " + $(v).text()

  else
    source = document.metaDescSource
  if source
    desc = source + " | " + base
  else
    desc = base
  $desc.attr "content", desc

setImage = ->
  base = ""
  $image = $("#meta-og-image")
  $source = $(".meta-image-source", "#container")
  source = $source and $source.attr("src") or document.metaImageSource
  if source
    url = source
  else
    url = base
  $image.attr "content", url

Backbone.History::loadUrl = (fragment) ->
  fragment = @fragment = @getFragment(fragment)
  _.any @handlers, (handler) ->
    if handler.route.test(fragment)
      handler.callback fragment
      if typeof window._gaq isnt "undefined"
        window._gaq.push [
          "_trackPageview"
          fragment
        ]
      true
