package com.yuxiaor.flutter.g_faraday_example;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;
import androidx.navigation.fragment.NavHostFragment;

import com.yuxiaor.flutter.g_faraday.FaradayFragment;

public class SecondFragment extends Fragment {


    @Override
    public View onCreateView(
            LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState
    ) {

        return inflater.inflate(R.layout.fragment_second, container, false);


    }

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        FaradayFragment flutterFragment = FaradayFragment.newInstance("native2flutter", null,true,0);
        FragmentTransaction ts = getChildFragmentManager().beginTransaction();
        ts.replace(R.id.left_fragment,flutterFragment);
        ts.commit();
        view.findViewById(R.id.button_second).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                NavHostFragment.findNavController(SecondFragment.this)
//                        .navigate(R.id.action_SecondFragment_to_FirstFragment);
                NavHostFragment.findNavController(SecondFragment.this)
                        .navigateUp();
                //              getActivity().startActivityForResult(FaradayActivity.Companion.builder("native2flutter",null,true).build(getContext()),1);
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

}