#-------------------------------------------------------------------------
#---     Copyright (c) COSMO CONSULT.  All rights reserved.            ---
#-------------------------------------------------------------------------

@{

    # Script module or binary module file associated with this manifest.
    # RootModule = ''
    
    # Version number of this module.
    ModuleVersion     = '1.0'
    
    # ID used to uniquely identify this module
    # GUID = ''
    
    # Author of this module
    Author            = 'COSMO CONSULT'
    
    # Company or vendor of this module
    CompanyName       = 'COSMO CONSULT'
    
    # Copyright statement for this module
    Copyright         = '© 2025 COSMO CONSULT. All rights reserved.'
    

    NestedModules     = @('API-Functions.psm1',
        'Get-AlpacaSettings.psm1',
        'Get-DependencyApps.psm1',
        'Get-ExtendedErrorMessage.psm1',
        'Publish-BCAppToDevEndpoint.psm1',
        'Wait-ForAlpacaContainer.psm1',
        'Wait-ForImage.psm1')

    # Functions to export from this module
    FunctionsToExport = '*'

    # Cmdlets to export from this module
    CmdletsToExport   = '*'

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module
    AliasesToExport   = '*'
}
