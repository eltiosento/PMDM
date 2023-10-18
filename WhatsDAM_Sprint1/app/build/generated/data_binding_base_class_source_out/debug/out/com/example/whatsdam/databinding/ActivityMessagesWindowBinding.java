// Generated by view binder compiler. Do not edit!
package com.example.whatsdam.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.example.whatsdam.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityMessagesWindowBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final EditText MessageText;

  @NonNull
  public final TextView connectionInfoTextView;

  @NonNull
  public final ImageButton sendMessage;

  private ActivityMessagesWindowBinding(@NonNull ConstraintLayout rootView,
      @NonNull EditText MessageText, @NonNull TextView connectionInfoTextView,
      @NonNull ImageButton sendMessage) {
    this.rootView = rootView;
    this.MessageText = MessageText;
    this.connectionInfoTextView = connectionInfoTextView;
    this.sendMessage = sendMessage;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityMessagesWindowBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityMessagesWindowBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_messages_window, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityMessagesWindowBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.MessageText;
      EditText MessageText = ViewBindings.findChildViewById(rootView, id);
      if (MessageText == null) {
        break missingId;
      }

      id = R.id.connectionInfoTextView;
      TextView connectionInfoTextView = ViewBindings.findChildViewById(rootView, id);
      if (connectionInfoTextView == null) {
        break missingId;
      }

      id = R.id.sendMessage;
      ImageButton sendMessage = ViewBindings.findChildViewById(rootView, id);
      if (sendMessage == null) {
        break missingId;
      }

      return new ActivityMessagesWindowBinding((ConstraintLayout) rootView, MessageText,
          connectionInfoTextView, sendMessage);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}