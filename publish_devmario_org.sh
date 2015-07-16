# if [[ "$OSTYPE" == "darwin"* ]]; then
# 	# Mac OSX
# 	scp -i ~/Documents/auth/fuckingUSA.pem ~/Documents/devmario.html ubuntu@52.69.162.111:/usr/share/nginx/html/devmario.html
# elif [[ "$OSTYPE" == "win32" ]]; then
# 	# I'm not sure this can happen.
# else
# 	# Unknown.
# 	# 리눅스 일때는 cp로 nginx에 위치하게
# fi

scp -i ~/Documents/auth/fuckingUSA.pem ~/Documents/devmario.html ~/Documents/devmario.org ubuntu@52.69.162.111:/usr/share/nginx/html/

