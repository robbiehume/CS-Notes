// Parent
...
<ChildComponent @success="handleSuccess()" />
...
function handleSuccess(){
  console.log('child event received')
}


// Child
...
const emit = defineEmits(['success'])
...
if(successful() == true){
  emit('success')
}
