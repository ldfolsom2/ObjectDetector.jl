using ObjectDetector, FileIO

yolomod = YOLO.v2_tiny_416_COCO(silent=true)
yolomod = YOLO.v3_tiny_416_COCO(silent=true)

batch = emptybatch(yolomod)
img = load(joinpath(dirname(dirname(pathof(ObjectDetector))),"test","images","dog-cycle-car.png"))

batch[:,:,:,1] .= gpu(resizePadImage(img, yolomod)) # Send resized image to the batch
res = yolomod(batch) # Run the model on the length-1 batch

imgBoxes = drawBoxes(img, res)

save(joinpath(@__DIR__,"result.png"), imgBoxes)

ObjectDetector.benchmark()
