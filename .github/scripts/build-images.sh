to_find="Dockerfile"

image_paths=$(find . -type f -name $to_find)

i=0
for image in $image_paths; do
        image_path=${image%"Dockerfile"}
        docker build -t img-${i}:${{ github.sha }} $image_path
        i=$((i+1))
done
