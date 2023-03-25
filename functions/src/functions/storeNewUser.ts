import functions from 'firebase-functions';
import { firestore } from '../services/firebase';

/**
 * Store a User doc when a new user signs up
 */
exports.storeNewUser = functions.auth.user().onCreate((user, context) => {
  firestore
    .collection('users')
    .doc(user.uid)
    .set({
      email: user.email || '',
      name: user.displayName || '',
    });
});
