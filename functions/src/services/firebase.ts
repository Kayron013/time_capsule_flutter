import * as _functions from 'firebase-functions';
import admin from 'firebase-admin';

admin.initializeApp();

export const firestore = admin.firestore();
export const functions = _functions;
export const logger = functions.logger;
