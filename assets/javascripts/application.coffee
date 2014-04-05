
#= require_tree javascripts/const

#= require javascripts/init.coffee

#= require_tree javascripts/utils
#= require_tree javascripts/locales

#= require javascripts/context.coffee

# load js files
`
//= require_tree javascripts/templates
`

#= require_tree javascripts/models
#= require_tree javascripts/collections
#= require_tree javascripts/views
#= require_tree javascripts/collection_views
#= require_tree javascripts/layouts
#= require_tree javascripts/routers
