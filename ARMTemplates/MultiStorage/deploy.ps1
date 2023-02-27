#Login-AzAccount 

New-AzResourceGroup -Name "ARMTemplates" -Location "CentralIndia"

New-AzResourceGroupDeployment -ResourceGroupName "ARMTemplates" -TemplateFile .\storagetemplate.json -TemplateParameterFile .\parameters.json -Verbose