import 'package:flutter/material.dart';

Widget ValidatorButton()
{
return ElevatedButton(
                  onPressed: () => null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Validate Design',
                    style: TextStyle(fontSize: 18),
                  ),
                );
}