#Login-AzAccount 

#New-AzResourceGroup -Name "ARMTemplates" -Location "CentralIndia"

New-AzResourceGroupDeployment -ResourceGroupName "ARMTemplates" -TemplateFile .\template.json -TemplateParameterFile .\parameters.json -Verbose