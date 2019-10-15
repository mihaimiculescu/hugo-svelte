#!/bin/sh
#start your new hugo&svelte project witn this

if [ ! -d /sveltedev/visible/svelte ]; then
cd /sveltedev/visible
cp -R /sveltedev/svelte . 
cd svelte
mkdir assets content data public static themes
fi
cd /sveltedev
npm run dev

#TODO	 address potential conflict for the public folder - both svelte and hugo create and use it
