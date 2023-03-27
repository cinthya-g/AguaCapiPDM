import 'package:flutter/material.dart';

class CrearUsuario extends StatelessWidget {
  CrearUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nueva cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(31, 70, 109, 1.0),
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // Email validation logic here
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Username validation logic here
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  // Password validation logic here
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  // Password confirmation validation logic here
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Gender:',
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromRGBO(243, 163, 110, 1)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'male',
                        groupValue: null,
                        onChanged: null,
                      ),
                      Text(
                        'Male',
                        style:
                            TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'female',
                        groupValue: null,
                        onChanged: null,
                      ),
                      Text(
                        'Female',
                        style:
                            TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'other',
                        groupValue: null,
                        onChanged: null,
                      ),
                      Text(
                        'Other',
                        style:
                            TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Date of Birth:',
                    style: TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Region:',
                    style: TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  ),
                  SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: null,
                    onChanged: null,
                    items: null,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Physical Activity:',
                    style: TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  ),
                  SizedBox(width: 16.0),
                  DropdownButton<String>(
                    value: null,
                    onChanged: null,
                    items: null,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Allow to use data for ranking:',
                    style: TextStyle(color: Color.fromRGBO(243, 163, 110, 1)),
                  ),
                  SizedBox(width: 16.0),
                  Switch(
                    value: false,
                    onChanged: null,
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 31, 70, 109),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Back',
                  style: TextStyle(
                    //underline
                    decoration: TextDecoration.underline,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(243, 163, 110, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
