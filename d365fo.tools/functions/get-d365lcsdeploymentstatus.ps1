﻿
<#
    .SYNOPSIS
        Start the deployment of a deployable package
        
    .DESCRIPTION
        Deploy a deployable package from the Asset Library from a LCS projcet using the API provided by Microsoft
        
    .PARAMETER ProjectId
        The project id for the Dynamics 365 for Finance & Operations project inside LCS
        
    .PARAMETER BearerToken
        The token you want to use when working against the LCS api
        
    .PARAMETER ActionHistoryId
        The unique id of the action that you started from the Invoke-D365LcsDeployment cmdlet
        
    .PARAMETER EnvironmentId
        The unique id of the environment that you want to work against

        The Id can be located inside the LCS portal

    .PARAMETER LcsApiUri
        URI / URL to the LCS API you want to use
        
        Depending on whether your LCS project is located in europe or not, there is 2 valid URI's / URL's
        
        Valid options:
        "https://lcsapi.lcs.dynamics.com"
        "https://lcsapi.eu.lcs.dynamics.com"
        
    .EXAMPLE
        PS C:\> Invoke-D365LcsDeployment -AssetId "adfasdfaf"
        
        This will deploy the file from LCS
        
    .NOTES
        Tags: Environment, Url, Config, Configuration, LCS, Upload, Api, AAD, Token, Deployment, Deploy
        
        Author: Mötz Jensen (@Splaxi)
        
#>

function Get-D365LcsDeploymentStatus {
    [CmdletBinding()]
    [OutputType('PSCustomObject')]
    param(
        [Parameter(Mandatory = $false, Position = 1)]
        [int] $ProjectId = $Script:LcsApiProjectId,
        
        [Parameter(Mandatory = $false, Position = 2)]
        [Alias('Token')]
        [string] $BearerToken = $Script:LcsApiBearerToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, Position = 3)]
        [string] $ActionHistoryId,

        [Parameter(Mandatory = $true, Position = 4)]
        [string] $EnvironmentId,

        [Parameter(Mandatory = $false, Position = 5)]
        [string] $LcsApiUri = $Script:LcsApiLcsApiUri
    )

    Invoke-TimeSignal -Start

    if (-not ($BearerToken.StartsWith("Bearer "))) {
        $BearerToken = "Bearer $BearerToken"
    }

    $deploymentStatus = Get-LcsDeploymentStatus -BearerToken $BearerToken -ProjectId $ProjectId -ActionHistoryId $ActionHistoryId -EnvironmentId $EnvironmentId -LcsApiUri $LcsApiUri

    Invoke-TimeSignal -End

    $deploymentStatus
}