if [ -f "artisan" ]; then

    diretorio=$(php artisan env:value --var=DIRETORIO)
    repositorio=$(php artisan env:value --var=GIT_REPOSITORIO)

elif [ -f "../artisan" ]; then

    diretorio=$(php ../artisan env:value --var=DIRETORIO)
    repositorio=$(php ../artisan env:value --var=GIT_REPOSITORIO)

fi

if [ ! -z "$diretorio" ]; then

    cd $diretorio && git reset HEAD --hard
    cd $diretorio && git stash
    cd $diretorio && git clean -d -f
    cd $diretorio && git pull $repositorio --tags --force

    npm install --prefix $diretorio/
    npm run prod --prefix $diretorio/

    supervisorctl stop all

    cd $diretorio && composer install --optimize-autoloader
    cd $diretorio && composer dump-autoload
    php $diretorio/artisan clear-compiled
    php $diretorio/artisan view:cache
    php $diretorio/artisan config:cache
    php $diretorio/artisan optimize:clear
    php $diretorio/artisan route:cache
    php $diretorio/artisan queue:restart

    supervisorctl start all

    php $diretorio/artisan migrate --force

    # APLICA AS PERMISSÕES
    chown -R www-data:www-data $diretorio
    chmod -R 777 $diretorio

fi
