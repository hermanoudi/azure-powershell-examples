#conecta na conta
az login

#lista todos webapps da conta
az webapp list

#lista todos os serviceplans
az appservice plan list

#cria um novo appservice plan
az appservice plan create -g AZURE-TREINAMENTO-WEBAPP -n planoappservicecli 

#cria um novo webapp
az webapp create -g AZURE-TREINAMENTO-WEBAPP -p planoappservicecli -n treinamentoWebAppCLI

#cria um novo slot de deploy
az webapp deployment slot create --name treinamentoWebAppCLI --resource-group AZURE-TREINAMENTO-WEBAPP --slot stage 

