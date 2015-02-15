# Export Plugin
module.exports = (BasePlugin) ->
    # Define Plugin
    class RoutingPlugin extends BasePlugin
        # Plugin name
        name: 'routing'

        # Configuration
        # TODO: Should there be different types of routing?
        #       Like based not only on paths, with replaces,
        #       but also according to different metadata etc.
        config:
            routes: []

        # Render some content synchronously
        renderBefore: (opts) ->
            config = @config
            docpad = @docpad
            routes = config.routes

            this.docpad.getCollection('documents').forEach (document) ->
                newOutPath = document.get('outPath')
                newUrl = document.get('url')

                for own before, after of routes
                    newOutPath = newOutPath.replace(before, after)
                    newUrl = newUrl.replace(before.replace(/^\//,''), after.replace(/^\//,''))

                document.set('outPath', newOutPath)
                document.setUrl(newUrl)