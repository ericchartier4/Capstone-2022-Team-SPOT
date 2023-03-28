import 'package:demo/Utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../Routes/routes.dart';

AlertDialog getLegal(context, nextAction,authController)
{
    AlertDialog legalDialog =  AlertDialog(
       title:  const Text("Terms & Conditions"),
       content:const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Text(  legalText),
                


       ),
       
       actions: <Widget>[
            TextButton(
              onPressed: () {Navigator.pop(context, 'Disagree');
                              Get.offAllNamed(Routes.LOGIN_SCREEN);
              
              } ,
              child: const Text('Disagree'),
            ),
            TextButton(
              onPressed: () async {Navigator.pop(context, 'Agreee');
                             if (nextAction == 0)
                             {
                               await Preference.shared.setString("useremail", 'nullnullnull');
                               await Preference.shared.setString("userpass", 'nullnullnull');
                               Get.toNamed(Routes.NEW_SCAN_SCREEN);
                             }
                             else
                             {
                              authController.signUpHelper(context);
                            
                             }

              
              },
              child: const Text('Agree'),
            ),
          ],
       
       
        );

  


return legalDialog;

}


const legalText =  '''At SPOT, we are committed to protecting the privacy and security of our users. This privacy policy describes how we collect, use, and disclose personal information in connection with your use of the SPOT service.

1. Information We Collect:

When you sign in and log in to SPOT, we collect the following information:
- Your name and email address
- Your skin scan images and history
- Any other information you provide to us
When you use the quick-scan function of SPOT, we do not collect any personal information or store any data in our database.

2. How We Use Information:
We use the information we collect from registered users to provide the SPOT service, including:
- Analyzing and storing your skin scan images and history
- Providing you with accurate and reliable evaluations of your skin health status
- Sending you relevant information and updates about your skin health
- Improving and optimizing the SPOT service
We do not sell or share your personal information with third parties for their direct marketing purposes.
How We Protect Information:

3. We use reasonable security measures to protect your personal information against unauthorized access, use, alteration, or disclosure. However, no data transmission over the internet or storage system can be guaranteed to be 100% secure.

4. Your Choices:
You can choose not to provide us with certain personal information, but this may limit your ability to use certain features of SPOT. You can also request to delete or modify your personal information by contacting us.

5. Changes to this Policy:
We may update this privacy policy from time to time, and any changes will be posted on our website. Your continued use of SPOT after any such changes constitutes your acceptance of the revised privacy policy.

6. Contact Us:
If you have any questions or concerns about this privacy policy or our practices with respect to your personal information, please contact us at crabuofr@gmail.com''';