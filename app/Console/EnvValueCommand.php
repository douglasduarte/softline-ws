<?php

namespace App\Console\Commands;

use App\Models\ConfigSistema;
use Illuminate\Console\Command;

class EnvValueCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'env:value {--var=APP_NAME}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = '.env value';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */

    public function handle()
    {
        echo env($this->option('var') );
    }

}
