#Login-AzAccount 

New-AzResourceGroup -Name "ARMTemplates" -Location "CentralIndia"

New-AzResourceGroupDeployment -ResourceGroupName "ARMTemplates" -TemplateFile .\vmtemplate.json -TemplateParameterFile .\parameters.json -Verbose