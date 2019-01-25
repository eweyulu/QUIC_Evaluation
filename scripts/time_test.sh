#!/bin/bash

$time=0
$num=0

for ((i=0; $i<5; i++))
	{
		$num=$(expr "$num" + 1)			
		print $num		
		print $i
	}

