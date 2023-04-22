import * as functions from 'firebase-functions';
import { User } from '../models';
import { firestore } from '../services/firebase';

/**
 * Store a User doc when a new user signs up
 */
exports.storeNewUser = functions.auth.user().onCreate(user => {
  firestore
    .collection('users')
    .doc(user.uid)
    .set({
      email: user.email || '',
      name: user.displayName || '',
      createdAt: Date.now(),
    } as User);
});
