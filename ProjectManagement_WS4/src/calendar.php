<?php
namespace App;

use Illuminate\Database\Eloquent\Model;

class calendar extends Model
{
    protected $table = 'calendar';  
    public $timestamps = false;    // Disabling the timestamps

    // Define the fillable fields
    protected $fillable = [
        'name', 'description', 'start_date', 'end_date', 'project_id'
    ];
}
