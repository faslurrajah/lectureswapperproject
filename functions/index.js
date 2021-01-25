const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().functions);

var newData;

exports.noticeAddedComp = functions.database.ref('main/royalputtalam/contents/{batch}/{subjects}/{id}').onCreate( async (evt,context) =>  {

    var subjectName="";
    var newsType = "";
    var temp = evt.val();
    var batchName=context.params.batch+" Batch";
    //var temp1 = temp.title+","+temp.des+","+temp.by+","+temp.created+","+temp.date+","+temp.due;
     if(context.params.subjects==="chemistry") subjectName = "Chemistry Theory";
     else if(context.params.subjects==="phy") subjectName = "Physics Theory";
     else if(context.params.subjects==="math") subjectName = "C.Maths Theory";
     else if(context.params.subjects==="bio") subjectName = "Biology Theory";
     else if(context.params.subjects==="pp") subjectName = "Physics Paper";
     else if(context.params.subjects==="mp") subjectName = "C.Maths Paper";
     else if(context.params.subjects==="bp") subjectName = "Biology Paper";
     else if(context.params.subjects==="cp") subjectName = "Chemistry Paper";

     var typeText='New '+temp.type;
     var title = typeText+"-"+subjectName+"-"+batchName;
     var body= temp.title;
    // else if(context.params.dept==="mech") deptName = "Mechanical Department";
    // else if(context.params.dept==="civil") deptName = "Civil Department";
    // var token = ['fa2fQBwsXO0:APA91bH2tgVVWFaq7hIjbtHb3NpvUP9L3FgpIr8UzwzXRm7DrsT7KBa7_i59RecB9AQoR6Vswqk5W4_CpK1qpSSCMDVilQ-Kaefbxa90gUEgXDl1JViAlRhu7rgLqivAOBbHebg8YMPh']
    const payload = {
        notification:{
            title : title,
            body : body,
            sound : 'default',

        },
        data:{
        message : context.params.subjects+","+context.params.batch+","+temp.title+","+temp.des+","+temp.type+","+temp.teacher+","+temp.date+","+temp.created,
        click_action : 'FLUTTER_NOTIFICATION_CLICK',
        }
    };
            //await admin.messaging().sendToDevice(token,payload);
            if(context.params.subjects==="phy")  admin.messaging().sendToTopic('phy'+context.params.batch,payload);
            else if(context.params.subjects==="chemistry")  admin.messaging().sendToTopic('chemistry'+context.params.batch,payload);
            else if(context.params.subjects==="bio")  admin.messaging().sendToTopic('bio'+context.params.batch,payload);
            else if(context.params.subjects==="math")  admin.messaging().sendToTopic('maths'+context.params.batch,payload);
            else if(context.params.subjects==="pp")  admin.messaging().sendToTopic('pp'+context.params.batch,payload);
            else if(context.params.subjects==="cp")  admin.messaging().sendToTopic('cp'+context.params.batch,payload);
            else if(context.params.subjects==="bp")  admin.messaging().sendToTopic('bp'+context.params.batch,payload);
            else if(context.params.subjects==="mp")  admin.messaging().sendToTopic('mp'+context.params.batch,payload);


});
