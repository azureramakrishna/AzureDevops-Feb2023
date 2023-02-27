#Login-AzAccount 

New-AzResourceGroup -Name "ARMTemplates" -Location "CentralIndia"

New-AzResourceGroupDeployment -ResourceGroupName "ARMTemplates" -TemplateFile .\multivmtemplate.json -TemplateParameterFile .\parameters.json -Verbose