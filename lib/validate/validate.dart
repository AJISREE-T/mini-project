

class validate{
  static String? txtvalidator(String value)
  {
    if(value.length<3)
      return "Invalid";
    else
      return null;
  }
  static String? phonevalidator(String value)
  {
    if(value.length!=10 || num.parse(value)==null)
      return "Invalid Phone number";
    else
      return null;
  }
  static String? pinvalidator(String value)
  {
    if(value.length!=6 || num.parse(value)==null)
      return "Invalid Pincode";
    else
      return null;
  }
  static String? emailValidator(String value) //Email Validation
  {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
    {
      return 'Email format is invalid';
    }
    else
    {
      return null;
    }
  }
  static String? passwordvalidator(String value)
  {
    if(value.length<8)
      return "Invalid Pass word";
    else
      return null;
  }
}
