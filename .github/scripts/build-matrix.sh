to_find="Dockerfile"

image_paths=$(find . -type f -name $to_find)

json='{"matrix": {"image_path":['
for image in $image_paths; do
        image_path=${image%"${to_find}"}
        #docker build -t img-$i:${{ github.sha }} $image_path
        json=$json'"'$image_path'",'
done
json=$json'],"include":['

i=1
for image in $image_paths; do
        image_path=${image%"${to_find}"}
        json=$json'{"image_path":"'$image_path'","image_name":"image-'$i'"},'
        i=$((i+1))
done

json=$json']}}'
echo $json | sed 's/,]/]/g' | json2yaml
