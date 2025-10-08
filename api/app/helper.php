<?php


if(!function_exists('uploadFile')){
    function uploadFile($file, $path)
    {
        $driver = env('FILESYSTEM_DRIVER');
        if ($driver == 'cloudinary') {
           $path =  Cloudinary::upload($file->getRealPath())->getSecurePath();
        }else{
            $path = Storage::disk(env('FILESYSTEM_DRIVER'))->put("public/$path", $file);
        }
        return $path;
    }
}