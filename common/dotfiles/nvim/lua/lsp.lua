local lspconfig = require('lspconfig')

lspconfig.ccls.setup({})

lspconfig.tsserver.setup({})

lspconfig.pyright.setup({
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportPrivateImportUsage = 'none',
                }
            }
        }
    }
})

lspconfig.metals.setup({})

lspconfig.rust_analyzer.setup({})
lspconfig.wgsl_analyzer.setup({})

lspconfig.texlab.setup({})
