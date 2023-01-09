//add it before overide in your class
var todaysDate = DateTime.now();

//This will open calender to pick up date
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
            //after we press oke then we are setting state to do something
            //in this case we are simply changinf vlaue of a text widget
        .then((value) => {

        setState(() {
          //null safety ! mark
          currentDate = value!;
        },)
        });
  }
